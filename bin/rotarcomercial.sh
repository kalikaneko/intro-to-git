#!/bin/bash
usuario=`whoami`
ultimo=`tail -n 1 /home/$usuario/.guarangoradio/data/tmp/comercialeslist`
echo $ultimo
sed -i "1i $ultimo" /home/$usuario/.guarangoradio/data/tmp/comercialeslist
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/comercialeslist

ultimo=`tail -n 1 /home/$usuario/.guarangoradio/data/tmp/comercialeslistweb`
sed -i "1i $ultimo" /home/$usuario/.guarangoradio/data/tmp/comercialeslistweb
sed -i '$d'  /home/$usuario/.guarangoradio/data/tmp/comercialeslistweb

ultimo=`tail -n 1 /home/$usuario/.guarangoradio/data/tmp/comercialeslistwebg3`
sed -i "1i $ultimo" /home/$usuario/.guarangoradio/data/tmp/comercialeslistwebg3
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/comercialeslistwebg3
exit 0
