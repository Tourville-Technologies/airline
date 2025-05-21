echo "===== STARTING MIGRATION ====="
cd /home/airline/airline/airline-data
for i in `seq 1 5`
do
  sbt "runMain com.patson.init.MainInit"
  if [ $? -eq 0 ]; then
    echo "Command succeeded on attempt $i"
    break
  else
    echo "Command failed on attempt $i, retrying in 5 seconds..."
    sleep 5
  fi
done
echo "===== DONE ====="