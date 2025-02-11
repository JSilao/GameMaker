function playerState_FREE(){
    //X Movement (Horizontal Movement)
    moveDir = rightKey - leftkey;

    //Get my face
    if moveDir != 0 { face = moveDir };

    // 🚀 **Faster Movement Speed**  
    runType = runKey;
    xspd = moveDir * moveSpd[runType] * 1.5;  // 1.5x speed boost  

    //X collision
    var _subPixel = .5;
    if place_meeting(x + xspd, y, obj_ground)
    {
        var _pixelCheck = _subPixel * sign(xspd);
        while !place_meeting(x + _pixelCheck, y, obj_ground)
        {
            x += _pixelCheck;
        }
        xspd = 0;
    }
    x += xspd;
    
    //Y Movement (Vertical Movement - Gravity, Jumping)
    if coyoteHangTimer > 0
    {
        coyoteHangTimer--;
    } else {
        // ⚡ **Much Faster Falling**  
        if yspd < 0 {  
            yspd += grav * 0.7;  // Lighter gravity while going up  
        } else {  
            yspd += grav * 3.5;  // 🔥 Even heavier gravity while falling  
        }

        // 🏀 **Sharp Drop if Jump Released Early**
        if !jumpKey && yspd < 0 {
            yspd += grav * 2.5;  // Fall even faster if jump is cut early  
        }
        
        setOnGround(false);
    }
    
    //Reset/Prepare Jumping variables
    if onGround
    {
        jumpCount = 0;
        coyoteJumpTimer  = coyoteJumpFrames;
    } else {
        coyoteJumpTimer--;
        if jumpCount == 0 && coyoteJumpTimer <= 0 { jumpCount = 1; };
    }
    
    //Initiate the Jump
    if jumpKeyBuffered && jumpCount < jumpMax
    {
        jumpKeyBuffered = false;
        jumpKeyBufferTimer = 0;
        
        jumpCount++;
        
        jumpHoldTimer = jumpHoldFrames[jumpCount-1] + 15; 
        
        setOnGround(false);
    }
    //Cut off the jump by releasing the jump button
    if !jumpKey
    {
        jumpHoldTimer = 0;
    }
    //Jump based on the timer/holding the button
    if jumpHoldTimer > 0
    {
        yspd = jspd[jumpCount-1] * 2.2;  // 🚀 STRONGER Initial Jump Force  
        jumpHoldTimer--;
    }
    
    //Y Collision (Handling Vertical Collisions)
    if yspd > termVel { yspd = termVel; };
    
    _subPixel = .5;
    if place_meeting(x, y + yspd, obj_ground)
    {
        var _pixelCheck = _subPixel * sign(yspd);
        while !place_meeting(x, y + _pixelCheck, obj_ground) { y += _pixelCheck };
            
        if yspd < 0 { jumpHoldTimer = 0; }
            
        yspd = 0;
    }
    
    //Set if I'm on the ground
    if yspd >= 0 && place_meeting(x, y+1, obj_ground)
    {
        setOnGround(true);
    }
    
    //Move
    y += yspd;

    //Sprite Control
    if abs(xspd) > 0 { sprite_index = walkSpr; };
    if abs(xspd) >= moveSpd[1] { sprite_index = runSpr; };
    if xspd == 0 { sprite_index = idleSpr; };
    if !onGround { sprite_index = jumpSpr; };
    
    mask_index = maskSpr;
}
