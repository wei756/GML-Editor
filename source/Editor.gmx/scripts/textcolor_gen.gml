///textcolor_gen()
var quote = 0, comment = 0;
for(var yy = 0; yy < text_l; yy++)
{
    col[yy] = "";
    if (comment == 1)
        comment = 0;
    for(var xx = 0; xx < string_length(text[yy]); xx++)
    {
        var te = string_char_at(text[yy], xx + 1);
        //comment /* */
        if (comment == 2 && string_copy(text[yy], xx + 1, 2) == "*/") && quote == 0
        {
            comment = 0;
            col[yy] += "dd";
            xx++;
        }
        else if comment
        {
            col[yy] += ".";
        }
        else if (string_copy(text[yy], xx + 1, 2) == "/*") && quote == 0
        {
            comment = 2;
            col[yy] += "dd";
            xx++;
        }
        //comment //
        else if (string_copy(text[yy], xx + 1, 2) == "//") && quote == 0
        {
            comment = 1;
            col[yy] += "dd";
            xx++;
        }
        //"Value"
        else if te == "'" && quote != 2
        {
            quote = !quote;
            col[yy] += "c";
        }
        else if te == '"' && quote != 1
        {
            quote = !quote * 2;
            col[yy] += "c";
        }
        else if quote == 0
        {
            //digit
            var pte = string_char_at(text[yy], xx);
            if (ord(te) >= 48 && ord(te) <= 57) || (ord(pte) >= 48 && ord(pte) <= 57 && pte == ".")
            {
                col[yy] += "c";
            }
            else
            {
                //keyword, function, constant, ...etc
                var func = "", ind = -1;
                for(var i = xx; i < string_length(text[yy]); i++)
                {
                    ind =  i;
                    var tt = string_char_at(text[yy], i + 1);
                    if (tt == " " || ds_list_find_index(highlight[0], tt) != -1 || ds_list_find_index(highlight[1], tt) != -1)
                    {
                        i = -1;
                        break;
                    }
                }
                func = string_copy(text[yy], xx + 1, ind - xx + (i != -1));
                if func != "" && (xx == 0 || string_char_at(text[yy], xx) == " " || ds_list_find_index(highlight[0], string_char_at(text[yy], xx)) != -1 || ds_list_find_index(highlight[1], string_char_at(text[yy], xx)) != -1)
                {
                    var ind = -1;
                    for(var i = 6; i > 1; i--)
                    {
                        ind = ds_list_find_index(highlight[i], func);
                        if (ind != -1)
                        {
                            repeat(string_length(func))
                            {
                                col[yy] += chr(ord("a") + highcolor[i]);
                                
                            }
                            xx += string_length(func) - 1;
                            break;
                        }
                    }
                    if (ind == -1)
                        col[yy] += "a";
                }
                else
                    col[yy] += "a";
            }
        }
        else
        {
            col[yy] += ".";
        }
    }
}
