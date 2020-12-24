# Terminal output control (http://www.termsys.demon.co.uk/vtansi.htm)

TC='\e['

CLR_LINE_START="${TC}1K"
CLR_LINE_END="${TC}K"
CLR_LINE="${TC}2K"

# Hope no terminal is greater than 1k columns
RESET_LINE="${CLR_LINE}${TC}1000D"

# Colors and styles (based on https://github.com/demure/dotfiles/blob/master/subbash/prompt)

Bold="${TC}1m"    # Bold text only, keep colors
Undr="${TC}4m"    # Underline text only, keep colors
Inv="${TC}7m"     # Inverse: swap background and foreground colors
Reg="${TC}22;24m" # Regular text only, keep colors
RegF="${TC}39m"   # Regular foreground coloring
RegB="${TC}49m"   # Regular background coloring
Rst="${TC}0m"     # Reset all coloring and style

# Basic            High Intensity      Background           High Intensity Background
Black="${TC}30m";  IBlack="${TC}90m";  OnBlack="${TC}40m";  OnIBlack="${TC}100m";
Red="${TC}31m";    IRed="${TC}91m";    OnRed="${TC}41m";    OnIRed="${TC}101m";
Green="${TC}32m";  IGreen="${TC}92m";  OnGreen="${TC}42m";  OnIGreen="${TC}102m";
Yellow="${TC}33m"; IYellow="${TC}93m"; OnYellow="${TC}43m"; OnIYellow="${TC}103m";
Blue="${TC}34m";   IBlue="${TC}94m";   OnBlue="${TC}44m";   OnIBlue="${TC}104m";
Purple="${TC}35m"; IPurple="${TC}95m"; OnPurple="${TC}45m"; OnIPurple="${TC}105m";
Cyan="${TC}36m";   ICyan="${TC}96m";   OnCyan="${TC}46m";   OnICyan="${TC}106m";
White="${TC}37m";  IWhite="${TC}97m";  OnWhite="${TC}47m";  OnIWhite="${TC}107m";

# examples
# echo "${Bold}${Red}bold red on ${OnBlue}blue background,${RegB} now back to regular background, ${RegF}regular foreground and ${Reg}regular text"
# echo "${Bold}${Undr}${Green}You can reset this whole style in one${Rst} command"
# echo -n "${Bold}${Blue}${OnWhite}bold blue text on white background${Rst}"; sleep 3; echo "${RESET_LINE}${Red}${OnYellow}becomes red text on yellow background${Rst}"


function print() {
    color=$1
    text=$2
    echo -e "${!color}$text$Rst"
}