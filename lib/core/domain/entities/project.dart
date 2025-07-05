class Project {
  final String title;
  final String description;
  final String imagePath;
  final List<String> technologies;
  final String category;
  // While not used in the PortfolioPage, adding 'tags' back 
  // to prevent future errors with InnovativeProjectCard.
  final List<String> tags;

  const Project({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.technologies,
    required this.category,
    this.tags = const [], // Default to an empty list
  });
}
