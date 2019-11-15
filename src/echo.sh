# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# @author   a-Sansara - https://git.pluie.org/meta-tech/bes-echo
# @app      bes-echo
# @license  GNU GPL v3
# @date     2017-05-13 23:50:54 CET
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.echo.boot ()
{
    BES_TERM_WIDTH=${COLUMNS:-130}
    BES_TERM_WIDTH=$(($BES_TERM_WIDTH - 20))
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.msg ()
{
    local c=${2:-}
    local m=${1:-}
    echo -e "    $c$m$Coff"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.state ()
{
    local len=14
    echo -en "      $Csep"
    printf "%0.s-" $(seq 1 $(($BES_TERM_WIDTH-${len})))
    if [ "$1" = 0 ]; then
        echo -e "$Coff $Cdone  OK  $Coff\n"
    else
        echo -e "$Coff $Cfail  KO  $Coff\n"
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.action ()
{
    local symbol=${3:-*}
    local  color=${4:-Citem}
    echo -e "    $Csymbol$symbol ${Caction}$1 ${!color}$2$Coff"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.title ()
{
    echo -e "\n  $Csymbol☪ $Ctitle$1 $Coff$Cspe$2$Coff\n"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.keyval ()
{
    local len=${3:-20}
    local c="$Ckey: ${Cval}"
    echo -e "   $Ckey $(printf "%-${len}s " "$1")  ${c}${2} $Coff"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.rs ()
{
    local rs=${1:-0}
    if [ "$rs" -eq 0 ]; then
        echo -e "  ${Cdone}  done  ${Coff}"
    else 
        echo -e "  ${Cfail}  failed  ${Coff}"
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.error ()
{
    local leave=${2:-0}
    echo -e "\n${Cerr}    error : ${Coff}\n\t$1 ${Coff}\n"
    if [ "$leave" = "1" ]; then
        exit 1;
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.sepline ()
{
    local  char=${1:-'_'}
    local width=${2:-$BES_TERM_WIDTH}
    echo -ne "${Cheadline} "
    printf "%0.s$char" $(seq 1 $width)
    echo -e "${Coff}"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function echo.app ()
{
    local     msg=${1:-''}
    local version=${2:-''}
    local  author=${3:-'a-Sansara'}
    local license=${4:-'GNU GPL v3'}
    if [ ! -z "$2" ]; then
        msg="$msg ${Cval}v$version"
    fi
    local     len="$1${version}license : $license   author:$author"
    echo.sepline
    echo -ne "\n  $Chead   $msg   $Coff"
    printf "%0.s " $(seq 1 $(($BES_TERM_WIDTH-${#len}-15)))
    echo -e " ${Cmeta}license : ${Coff}$license   ${Cmeta}author : ${Cval}$author"
    echo.sepline
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
declare -f bes.reg > /dev/null
if [ $? -eq 0 ]; then
    bes.reg bes.echo
fi
