## Material and Mouse driven theme for [AwesomeWM 4.3](https://awesomewm.org/)
### Original design by PapyElGringo,  modified by Chris Titus. 

## Baseado no titus-awesome

Esta fork é apenas uma tentativa pessoal de melhorar meu modo de trabalho, aprender, compartilhar e não perder minhas ideias.

## Instalação

#### Manjaro XFCE

Todas as minhas ações foram  feitas em uma instalação do manjaro XFCE, mas devem funcionar para outras distros baseadas em Arch

Deixar os seguintes repos funcionais: criarei um script para isso
    yay
    flatpack
    AUR


# Instalar os pacotes:

Tenho que atualizar esse comando apra meu uso mas segue aqui todos os programas q devo lembrar de instalar para o funcionamento completo do meu projeto:

```
yay -S awesome rofi picom xclip ttf-roboto polkit-gnome materia-theme lxappearance flameshot pnmixer network-manager-applet xfce4-power-manager qt5-styleplugins papirus-icon-theme -y
```
Programas necessários que o script não instala

i3lock e i3lock-fancy
pnmixer 
discord
thunderbird
libreoffice
nitrogen
spotify via flatpack -- no caso escolhi via flatpack, não sei se vindo de outro repo o comando vai ser o mesmo.

Com esses programas cada tag (ou área de trabalhom irá abrir o programa correspondente)

é possível configurar para ter mais áres de trabalho e masi tipos de programa.


#### Program list

- [AwesomeWM](https://awesomewm.org/) as the window manager - universal package install: awesome
- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font** - Debian: fonts-roboto Arch: ttf-roboto
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher - universal install: rofi
- [picom](https://github.com/yshui/picom) for the compositor (blur and animations) universal install: picom - Debian users need PPA (`sudo add-apt-repository ppa:regolith-linux/unstable`) _Note: I recommend Compton for Debian Users and the Debian Branch_
- [i3lock](https://github.com/meskarune/i3lock-fancy) the lockscreen application universal install: i3lock-fancy
- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard package: xclip
- [gnome-polkit] recommend using the gnome-polkit as it integrates nicely for elevating programs that need root access
- [Materia](https://github.com/nana-4/materia-theme) as GTK theme - Arch Install: materia-theme debian: materia-gtk-theme
- [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme Universal Install: wget -qO- https://git.io/papirus-icon-theme-install | sh
- [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme
- (Laptop) [xbacklight](https://www.x.org/archive/X11R7.5/doc/man/man1/xbacklight.1.html) for adjusting brightness on laptops (disabled by default)
- [flameshot](https://flameshot.org/) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the apps.lua file
- [pnmixer](https://github.com/nicklan/pnmixer) Audio Tray icon that is in debian repositories and is easily installed on arch through AUR.
- [network-manager-applet](https://gitlab.gnome.org/GNOME/network-manager-applet) nm-applet is a Network Manager Tray display from GNOME.
- [xfce4-power-manager](https://docs.xfce.org/xfce/xfce4-power-manager/start) XFCE4's power manager is excellent and a great way of dealing with sleep, monitor timeout, and other power management features.

### 2) Clonar os arquivos de configuração:

Arch-Based Installs
```
git clone https://github.com/Byronico-PRS/my_awesome1 ~/.config/awesome
```
### 3) Ligar configurações do Rofi com os arquivos de configuração já baixados

Set Rofi Theme

```
mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

```

### 4) Same theme for Qt/KDE applications and GTK applications, and fix missing indicators

First install  `qt5-styleplugins` (arch) and add this to the bottom of your `/etc/environment`

```bash
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```

The first variable fixes most indicators (especially electron based ones!), the second tells Qt and KDE applications to use your gtk2 theme set through lxappearance.

### 5) Read the documentation

The documentation live within the source code.

The project is split in functional directories and in each of them there is a readme where you can get additional information about the them.

* [Configuration](./configuration) is about all the **settings** available
* [Layout](./layout) hold the **disposition** of all the widgets
* [Module](./module) contain all the **features** available
* [Theme](./theme) hold all the **aesthetic** aspects
* [Widget](./widget) contain all the **widgets** available
