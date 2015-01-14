#! /bin/bash

OPTS=$(
    getopt --options c:p --long control:,playpause -n 'mediacontrol.sh' -- "$@"
)
eval set -- "$OPTS"

while true; do
    case "$1" in
        -c|--control)
            case "$2" in
                "") 
                    printf "Name of program needed (i.e. moc, rhythmbox)\n"; shift 2 ;;
                [mM][oO][cC])
                    echo "moc" > $HOME/.mediacontrol; shift 2;;
                rbox|rb|[rR]hythmbox)
                    echo "Rhythmbox" > $HOME/.mediacontrol; shift 2;;
                "*") printf "%s: Program not known\n" $2; shift 2 ;;
            esac ;;
        -p|--playpause)
            if [ -f $HOME/.mediacontrol ];
            then
                PLAYER=$(cat $HOME/.mediacontrol)
            else
                PLAYER="Rhythmbox"
                echo "Rythmbox" > $HOME/.mediacontrol
            fi
            case "$PLAYER" in
                "moc")
                    mocp -G ;;
                "Rhythmbox")
                    rhythmbox-client --play-pause ;;
            esac 
            break;;
        --) shift; break ;;
    esac
done
