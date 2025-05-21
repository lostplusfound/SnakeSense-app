class Species {
  final String binomialName;
  final String commonName;
  final String country;
  final String continent;
  final String genus;
  final String family;
  final String snakeSubFamily;
  final bool poisonous;

  Species({
    required this.binomialName,
    required this.commonName,
    required this.country,
    required this.continent,
    required this.genus,
    required this.family,
    required this.snakeSubFamily,
    required this.poisonous,
  });

  factory Species.fromCsvRow(List<dynamic> row) {
    return Species(
      binomialName: row[2],
      commonName: row[3],
      country: row[4],
      continent: row[5],
      genus: row[6],
      family: row[7],
      snakeSubFamily: row[8],
      poisonous: row[9] == 1,
    );
  }
}