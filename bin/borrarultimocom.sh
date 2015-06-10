#!/bin/bash
usuario=`whoami`
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/comercialeslist
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/comercialeslistweb
sed -i '$d' /home/$usuario/.guarangoradio/data/tmp/comercialeslistwebg3
exit 0
