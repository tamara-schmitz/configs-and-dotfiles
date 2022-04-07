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
</fontconfig>
```
