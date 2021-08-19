# git clone https://github.com/r-ricdeau/host-switch-aspl.git
# cd host-switch-aspl
# sed 's/lf/.10f/g' main.cpp > a
# mv a main.cpp
# make
# cd ..
BASE=/Users/mnakao/Desktop/ORP/sample
for g in $(ls -1 *.edges); do
    echo $g
    ./host-switch-aspl/h-aspl $g > a
    ORP_DISCONNECTED=1 ${BASE}/simple.x $g | grep "ASPL   " | awk '{print $3}' > b
    ORP_DISCONNECTED=1 ${BASE}/simple.x $g | grep "Diameter  " | awk '{print $3}' >> b
    diff a b || exit
done
echo "OK"
for g in $(ls -1 *.edges); do
    echo $g
    ./host-switch-aspl/h-aspl $g > a
    ${BASE}/simple.x $g | grep "ASPL   " | awk '{print $3}' > b
    ${BASE}/simple.x $g | grep "Diameter  " | awk '{print $3}' >> b
    diff a b || echo "OK"
done
rm -f a b
