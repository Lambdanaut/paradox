extends Node

signal bgm_stopped
signal fade_completed

enum FadeType {OUT, IN}

const NUM_PLAYERS: int = 32
const BUS := "master"
const DEFAULT_BGM_VOLUME: float = -10.0  # BGM volume in decibles
const DEFAULT_SFX_VOLUME: float = 0.0

const DEFAULT_SOUND_RADIUS: float = 500.0

# Constants for calculating volume at a distance
const SILENCE_VOLUME: float = -80.0  # Sound is barely perceptible at this volume

const _sound_map := {
	# Music (don't preload music because it's a lot to keep in memory)
#	"kickboxing-1" : "res://data/audio/music/Kickboxing 1.ogg",

	# Sound fx
	"button-pressed": preload("res://data/audio/sfx/button-pressed.wav"),
	"cant-move": preload("res://data/audio/sfx/cant-move.wav"),
	"clone": preload("res://data/audio/sfx/clone.wav"),
	"epoch": preload("res://data/audio/sfx/epoch.wav"),
	"lose": preload("res://data/audio/sfx/lose.wav"),
}

var is_bgm_enabled := true

var _default_bgm := ""  # The name of the bgm to return to after swapping it out
var _current_bgm := ""  # The name of the current bgm being played. 
var _queued_bgm := ""  # The name of the next bgm to be played. 
var _bgm_is_locked := false  # Whether changing the background music is temporarily locked or not
var _locked_bgm := ""  # BGM to play when we unlock the music player
var _available_players := []  # The available players.
var _sfx_queue := []  # The queue of sounds to play.

# AudioStreamPlayer reserved for music
var music_stream_player: AudioStreamPlayer


func _ready():
	# Don't stop audio from playing while game is paused
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	# Reserve an AudioStreamPlayer2D exclusively for playing bgm
	music_stream_player = AudioStreamPlayer.new()
	music_stream_player.volume_db = DEFAULT_BGM_VOLUME
	music_stream_player.bus = BUS
	add_child(music_stream_player)

	# Create the pool of AudioStreamPlayer2D nodes for sound effects
	for i in NUM_PLAYERS:
		var p = AudioStreamPlayer2D.new()
		p.connect("finished", self, "_on_stream_finished", [p])
		p.bus = BUS
		
		p.max_distance = DEFAULT_SOUND_RADIUS
		p.attenuation = 2.0  # Exponentially decrease sound as we move from its location
		
		_available_players.append(p)
		add_child(p)

func _physics_process(delta):
	if not _sfx_queue.empty() and not _available_players.empty():
		# Play a queued sound if any players are available.
		var available_audio_stream: AudioStreamPlayer2D = _available_players.pop_front()

		var queued_sfx: Array = _sfx_queue.pop_front()
		var sfx_name: Resource = queued_sfx[0]
		var sfx_position: Vector2 = queued_sfx[1]

		available_audio_stream.global_position = sfx_position

		available_audio_stream.set_volume_db(DEFAULT_SFX_VOLUME)
		available_audio_stream.stream = sfx_name
		available_audio_stream.play()

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	stream.global_position = Vector2.ZERO
	_available_players.append(stream)

func initialize(default_bgm:="", bgm_enabled:=true):
	# Optionally to be called when the root scene loads to start background music and other tasks
	
	is_bgm_enabled = bgm_enabled
	
	# Start playing default music
	set_default_bgm(default_bgm)
	play_default_bgm(false)

func set_default_bgm(default_bgm: String):
	_default_bgm = default_bgm

func play(sound_name: String, sound_position=null):
	# Play a sound given by `sound_name` found in the `_sound_map`
	
	if sound_position == null:
		sound_position = Vector2(0.0, 0.0)

	var sound_path: Resource = _sound_map[sound_name]
	_sfx_queue.append([sound_path, sound_position])

func play_bgm(sound_name: String, with_fade: bool=true):
	if !is_bgm_enabled:
		return

	if _bgm_is_locked:
		# Update the _locked_bgm and return without playing or stopping anything
		_locked_bgm = sound_name
		return

	var sound_path: String = _sound_map[sound_name]
	
	# Remember the bgm we want to play after stopping
	_queued_bgm = sound_name

	# Stop the ongoing audio
	if _current_bgm:
		stop_bgm(with_fade)

		if with_fade:
			yield(self, "bgm_stopped")

	if _queued_bgm == sound_name:
		# If the queued bgm hasn't changed during the stop process, play the new bgm

		# Update the current_bgm
		_current_bgm = sound_name

		# Play the new BGM
		music_stream_player.volume_db = DEFAULT_BGM_VOLUME  # The volume may have been changed, so we reset it 
		music_stream_player.stream = load(sound_path)
		music_stream_player.play(0)
		if with_fade:
			_fade_audio_stream(music_stream_player, FadeType.IN)

func play_default_bgm(with_fade: bool=true):
	if _default_bgm:
		play_bgm(_default_bgm, with_fade)
	else:
		stop_bgm(with_fade)

func stop_bgm(with_fade: bool=true):
	if _bgm_is_locked:
		# Return without making any audible changes. 
		_locked_bgm = ""
		return

	if not _current_bgm:
		return

	_current_bgm = ""

	if with_fade:
		_fade_audio_stream(music_stream_player, FadeType.OUT)
		yield(self, "fade_completed")

	if not _current_bgm:  # If we still don't have a _current_bgm set after the fade, stop the bgm
		music_stream_player.stop()
	
	emit_signal("bgm_stopped")

func toggle_bgm_locked(new_locked_state: bool, sound_name:="", with_fade: bool=true):
	# Can be used to temporarily lock playing any other bgm. 
	# When the bgm is unlocked, it will resume whatever was being muted. 
	if new_locked_state:
		_locked_bgm = _current_bgm
		if sound_name:
			play_bgm(sound_name, with_fade)
		else:
			stop_bgm(with_fade)

	# Update the locked state
	_bgm_is_locked = new_locked_state

	if not new_locked_state:
		if _locked_bgm:
			play_bgm(_locked_bgm, with_fade)

func _fade_audio_stream(stream_player, fade_type: int, transition_duration: float=1.0, transition_type: int=Tween.TRANS_LINEAR):
	# Fades an audio from a stream_player in or out
	
	var start_volume_db: float
	var end_volume_db: float
	var ease_type: int

	# Determine our starting and ending volume db based on the `fade_type`
	if fade_type == FadeType.OUT:
		# Fade to silence
		start_volume_db = stream_player.volume_db
		end_volume_db = SILENCE_VOLUME
		ease_type = Tween.EASE_OUT
	elif fade_type == FadeType.IN:
		# Fade from silence
		start_volume_db = SILENCE_VOLUME
		end_volume_db = stream_player.volume_db
		ease_type = Tween.EASE_IN
	else:
		return

	# Create Tween nodes for fading in/out
	var tween: Tween = Tween.new()
	add_child(tween)
	
	# Tween the volume over time
	tween.interpolate_property(
		stream_player,
		"volume_db",
		start_volume_db,
		end_volume_db,
		transition_duration,
		transition_type,
		ease_type
	)
	tween.start()

	# Wait until we reach silence
	yield(tween, "tween_completed")

	# Clean up the tween
	tween.queue_free()

	emit_signal("fade_completed")
