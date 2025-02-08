part_system_drawit(global._part_system);
	var camera = view_get_camera(0);
if (!surface_exists(self.light_surface)) {
	camera = view_get_camera(0);
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);

	self.light_surface = surface_create(cam_width,cam_height);
}

surface_set_target(self.light_surface);
draw_clear(c_black);
camera_apply(camera);

gpu_set_blendmode(bm_subtract);

//Simple adjustments on x and y because i dont have the point on middle its on bottom middle
if (global.scale == 1){
		with (objectPlayer) {
		draw_sprite_ext(spr_light, 0, self.x - 140, self.y - 160, global.scale, global.scale, 0, c_white, 1);
	}
}else {
	with (objectPlayer) {
		draw_sprite_ext(spr_light, 0, self.x - 200, self.y - 220, global.scale, global.scale, 0, c_white, 1);
	}
}

gpu_set_blendmode(bm_normal);

surface_reset_target();