#!/bin/bash

# Poproś użytkownika o datę początkową w formacie 'YYYY-MM-DD HH:MM:SS'
echo "Podaj datę początkową w formacie 'YYYY-MM-DD HH:MM:SS':"
read start_date

# Sprawdzenie poprawności formatu daty
start_timestamp=$(date -d "$start_date" "+%Y-%m-%d %H:%M:%S")

if [ $? -ne 0 ]; then
  echo "Nie udało się przetworzyć daty. Upewnij się, że format jest poprawny (YYYY-MM-DD HH:MM:SS)."
  exit 1
fi

# Inicjalizowanie początkowego czasu
current_time=$start_timestamp

# Pętla po wszystkich plikach .jpg w folderze
for file in *.jpg; do
  # Sprawdzenie, czy to plik
  [ -f "$file" ] || continue

  # Użycie exiftool do zmiany daty w metadanych (o 1 sekundę)
  exiftool -AllDates="$current_time" "$file"

  # Zwiększenie czasu o 1 sekundę (ponownie formatujemy do poprawnego formatu)
  current_time=$(date -u -d "$current_time 1 sec" "+%Y-%m-%d %H:%M:%S")

  # Usunięcie kopii zapasowej, którą tworzy exiftool
  rm -f "${file}_original"
done

echo "Daty w metadanych zostały zaktualizowane dla wszystkich plików JPG."
