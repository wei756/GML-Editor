///kor_input()
//arranged for gmgm project
keyentered = 0;

if !keyboard_check(vk_nokey)
    time = current_time;
if (keyboard_check_pressed(vk_anykey) || keyboard_check(vk_nokey) || prev_key != keyboard_lastkey) // 연속 키
    key_time = current_time;

if keyboard_check_pressed(kor_keyHan)
{
    if (kor_mode == "ko_kr")
    {
        kor_insert(text_eng_to_hangul(kor_buffer));
        kor_buffer = "";
        kor_mode = "en_us";
        keyentered++;
    }
    else
        kor_mode = "ko_kr";
}


// 단타
/*
for(var i = 65; i <= 90; i++)
if keyboard_check_pressed(i)
{
    kor_buffer += chr(i + !keyboard_check(vk_shift) * 32);
    keyentered++;
}
*/

if (keyboard_check_pressed(vk_anykey) && string_length(keyboard_string)) // 숫자, 특수기호 입력
{
    kor_buffer += keyboard_string;
    keyboard_string = "";
    keyentered++;
}

if keyboard_check_pressed(vk_backspace)
{
    
    if string_length(kor_buffer)
    {
        kor_buffer = string_delete(kor_buffer, string_length(kor_buffer), 1);
    }
    else
    {
        if (string_length(kor_string) && kor_cursor > 0)
        {
            kor_string = string_delete(kor_string, kor_cursor, 1);
            kor_cursor = max(kor_cursor - 1, 0);
        }
        else if cury > 0
        {
            kor_cursor = string_length(text[cury - 1]);
            text[cury - 1] += kor_string;
            kor_string = text[cury - 1];
            for(var i = cury; i < text_l - 1; i++)
            {
                text[i] = text[i + 1];
            }
            cury--;
            text_l--;
        }
    }
    keyentered++;
}
if keyboard_check_pressed(vk_enter)
{
    //버퍼 정리
    kor_insert(text_eng_to_hangul(kor_buffer));
    kor_buffer = "";
    //write line
    if cury < text_l - 1
    for(var i = text_l - 1 ; i > cury; i--)
    {
        text[i + 1] = text[i];
    }
    text_l++;
    //split text
    text[cury] = string_copy(kor_string, 1, kor_cursor);
    kor_string = string_delete(kor_string, 1, kor_cursor);
    
    cury++;
    kor_cursor = 0;
    keyentered++;
}
if (kor_arrow)
{
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
    {
        kor_insert(text_eng_to_hangul(kor_buffer));
        kor_buffer = "";
    }
    if keyboard_check_pressed(vk_left)
    {
        if kor_cursor == 0
        {
            kor_cursor = string_length(text[max(cury - 1, 0)]) * (cury > 0);
            text[cury] = kor_string;
            cury = max(cury - 1, 0);
            kor_string = text[cury];
        }
        else
            kor_cursor--;
    }
    if keyboard_check_pressed(vk_right)
    {
        if kor_cursor == string_length(text[cury])
        {
            kor_cursor = string_length(text[min(cury + 1, text_l - 1)]) * (cury == text_l - 1);
            text[cury] = kor_string;
            cury = min(cury + 1, text_l - 1);
            kor_string = text[cury];
        }
        else
            kor_cursor++;
    }
    if keyboard_check_pressed(vk_up)
    {
        if cury > 0
        {
            kor_cursor = min(kor_cursor, string_length(text[cury - 1]));
            text[cury] = kor_string;
            cury--;
            kor_string = text[cury];
        }
    }
    if keyboard_check_pressed(vk_down)
    {
        if cury != text_l - 1
        {
            kor_cursor = min(kor_cursor, string_length(text[cury + 1]));
            text[cury] = kor_string;
            cury++;
            kor_string = text[cury];
        }
    }
}

// 연속
if (current_time - key_time > kor_longpress)
{
    for(var i = 65; i <= 90; i++)
    if keyboard_check(i)
    {
        kor_buffer += chr(i + !keyboard_check(vk_shift) * 32);
        keyentered++;
    }
    
    if (keyboard_check(vk_anykey) && !(keyboard_key >= 65 && keyboard_key <= 90) && string_length(keyboard_string)) // 숫자, 특수기호 입력
    {
        kor_buffer += keyboard_string;
        keyboard_string = "";
        keyentered++;
    }
    if keyboard_check(vk_backspace)
    {
        if string_length(kor_buffer)
        {
            kor_buffer = string_delete(kor_buffer, string_length(kor_buffer), 1);
        }
        else
        {
            if (string_length(kor_string) && kor_cursor > 0)
            {
                kor_string = string_delete(kor_string, kor_cursor, 1);
                kor_cursor = max(kor_cursor - 1, 0);
            }
            else if cury > 0
            {
                kor_cursor = string_length(text[cury - 1]);
                text[cury - 1] += kor_string;
                kor_string = text[cury - 1];
                for(var i = cury; i < text_l - 1; i++)
                {
                    text[i] = text[i + 1];
                }
                cury--;
                text_l--;
            }
        }
        keyentered++;
    }
    if keyboard_check(vk_enter)
    {
        //버퍼 정리
        kor_insert(text_eng_to_hangul(kor_buffer));
        kor_buffer = "";
        //write line
        if cury < text_l - 1
        for(var i = text_l - 1 ; i > cury; i--)
        {
            text[i + 1] = text[i];
        }
        text_l++;
        //split text
        text[cury] = string_copy(kor_string, 1, kor_cursor);
        kor_string = string_delete(kor_string, 1, kor_cursor);
        
        cury++;
        kor_cursor = 0;
        keyentered++;
    }
    if (kor_arrow)
    {
        if keyboard_check(vk_left)
        {
            if kor_cursor == 0
            {
                kor_cursor = string_length(text[max(cury - 1, 0)]) * (cury > 0);
                text[cury] = kor_string;
                cury = max(cury - 1, 0);
                kor_string = text[cury];
            }
            else
                kor_cursor--;
        }
        if keyboard_check(vk_right)
        {
            if kor_cursor == string_length(text[cury])
            {
                kor_cursor = string_length(text[min(cury + 1, text_l - 1)]) * (cury == text_l - 1);
                text[cury] = kor_string;
                cury = min(cury + 1, text_l - 1);
                kor_string = text[cury];
            }
            else
                kor_cursor++;
        }
        if keyboard_check(vk_up)
        {
            if cury > 0
            {
                kor_cursor = min(kor_cursor, string_length(text[cury - 1]));
                text[cury] = kor_string;
                cury--;
                kor_string = text[cury];
            }
        }
        if keyboard_check(vk_down)
        {
            if cury != text_l - 1
            {
                kor_cursor = min(kor_cursor, string_length(text[cury + 1]));
                text[cury] = kor_string;
                cury++;
                kor_string = text[cury];
            }
        }
    }
}
keyboard_string = "";
prev_key = keyboard_lastkey;
