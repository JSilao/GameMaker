// Step event
move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x *= move_speed;

var slope_check_y = y + 2; // Offset for checking if we're on ground/slope

// Check if the player is on the ground or slope
if (place_meeting(x, slope_check_y, obj_ground)) {
    move_y = 0;  // Reset vertical velocity when grounded
    if (keyboard_check(vk_space)) {
        move_y = -jump_speed; // Jumping
    }
} else if (move_y < 10) {
    move_y += 1; // Gravity
}

// Move the player and check for collision with obj_ground
move_and_collide(move_x, move_y, obj_ground);

// Handle slopes — checking the ground under the player for slope adjustments
if (!place_meeting(x + move_x, slope_check_y, obj_ground) && place_meeting(x + move_x, y + 10, obj_ground)) {
    // Snap player to the slope — adjust move_y to be in line with the slope
    var slope_angle = abs(move_x);
    move_y = slope_angle; // Align the player to the slope's angle
    move_x = 0; // Stop horizontal movement (effectively "locking" the player on the slope)
}

// Flip the sprite based on direction
if (move_x != 0) {
    image_xscale = sign(move_x);
}
