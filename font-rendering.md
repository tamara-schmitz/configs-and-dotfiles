https://pandasauce.org/post/linux-fonts/ explains a lot.

TLDR, It's a mess.

Also please note that this only applies if your applications supports native
dpi, aka you don't mix display DPIs or fractional scaling as then the rasterised
picture gets scaled. In these scenarios you should follow the instructions but
make sure that subpixel rendering is off!

1. Install nice fonts. just install all noto fonts

2. Install MS Fonts not by using msttcorefonts package but rather by copying
fonts all fonts from `C:\Windows\Fonts` and copying them into
`/usr/share/fonts/fromwindows/`.

3. GNOME Tweak Tool. Set font antialiasing to Subpixel and Hinting to Slight.
Favourite fonts:
- Interface text: Noto Sans Medium 11
- Document text: Cantarell Regular 11
- Monospace text: Source Code Pro Medium 10
- Legacy Window Titles: Cantarell Bold 11

4. Assign a subpixel geometry system wide in /etc/fonts/local.conf
Usually its:

```xml
<fontconfig>
  <match target="font">
    <edit name="autohint" mode="assign">
      <bool>false</bool>
    </edit>
    <edit name="hinting" mode="assign">
      <bool>true</bool>
    </edit>
    <edit name="antialias" mode="assign">
      <bool>true</bool>
    </edit>
    <edit mode="assign" name="hintstyle">
      <const>hintslight</const>
    </edit>
    <edit mode="assign" name="rgba">
      <const>rgb</const>
    </edit>
    <edit mode="assign" name="lcdfilter">
      <const>lcddefault</const>
    </edit>
  </match>
  <match target="pattern">
      <test name="family" qual="any">
        <string>monospace</string>
      </test>
      <edit binding="strong" mode="prepend" name="family">
        <string>Source Code Pro</string>
      </edit>
  </match>

</fontconfig>
```

Buuut wait. This might be overwritten by a config file somewhere else. So make
sure to check that these options are not overwritten elsewhere, and if they are
remove the whole `<match>` section overwriting them in these locations:

- `~/.fonts.conf`
- `~/.config/fontconfig/fonts.conf`

## Potential broken font fix

I encountered this before. If some applications seem broken, try fixing your
permissions using `chmod -R 0755 /usr/share/fonts`
