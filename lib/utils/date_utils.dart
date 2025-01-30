String formatExpirationDate(String expiration) {
  try {
    DateTime parsedDate = DateTime.parse(expiration);
    return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
  } catch (e) {
    return expiration;
  }
}

String formatDosageInterval(String interval) {
  try {
    DateTime parsedDate = DateTime.parse(interval);
    Duration difference =
        parsedDate.isAfter(DateTime.now()) ? parsedDate.difference(DateTime.now()) : Duration.zero;

    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;

    // Formata a string de acordo com a diferença de tempo
    if (hours > 0) {
      return '$hours hora(s) ${minutes}m';
    } else if (minutes > 0) {
      return '$minutes minuto(s)';
    } else {
      return 'Agora';
    }
  } catch (e) {
    return interval;
  }
}
