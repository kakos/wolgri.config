BAT="$(acpi -b | tr -d [:punct:][:alpha:][:space:] | sed 's/.//')"
AC="$(acpi -B -a | sed 's/[^A-Z].AC Adapter 0: //' )"

echo $AC $BAT
