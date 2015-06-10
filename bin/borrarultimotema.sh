#!/bin/bash
usuario=`whoami`
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/playlist
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/playlistweb
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/playlistg3
/home/$usuario/.guarangoradio/bin/cartucho.sh
exit 0
