extends Node

var config_path := "user://settings.cfg"

func save_volume(value: float) -> void:
	var cfg = ConfigFile.new()
	cfg.set_value("audio", "volume", value)
	cfg.save(config_path)

func load_volume(default_value: float = 50.0) -> float:
	var cfg = ConfigFile.new()
	if cfg.load(config_path) == OK:
		return cfg.get_value("audio", "volume", default_value)
	return default_value
