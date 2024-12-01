counter=0
while [ $counter -lt 42 ]; do
  echo "Counter: $counter"
#  project_clang_debug run1rule_v3.xml > run1rule_v3.out
  template_sample run1rule_v3.xml > run1rule_v3.out
  ((counter++))
done
