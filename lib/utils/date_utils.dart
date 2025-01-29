String formatExpirationDate(String expiration) {
  try {
    DateTime parsedDate = DateTime.parse(expiration);
    return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
  } catch (e) {
    return expiration;
  }
}
