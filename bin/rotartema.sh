#!/bin/bash
usuario=`whoami`
ultimo=`tail -n 1 /home/$usuario/.guarangoradio/data/tmp/playlist`
echo $ultimo
sed -i "1i $ultimo" /home/$usuario/.guarangoradio/data/tmp/playlist
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/playlist

ultimo=`tail -n 1 /home/$usuario/.guarangoradio/data/tmp/playlistweb`
sed -i "1i $ultimo" /home/$usuario/.guarangoradio/data/tmp/playlistweb
sed -i '$d'  /home/$usuario/.guarangoradio/data/tmp/playlistweb

ultimo=`tail -n 1 /home/$usuario/.guarangoradio/data/tmp/playlistg3`
sed -i "1i $ultimo" /home/$usuario/.guarangoradio/data/tmp/playlistg3
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/playlistg3
/home/$usuario/.guarangoradio/bin/cartucho.sh
exit 0
