enum Role implements Comparable<Role> {
  worker(id: 1, title: 'Colaborador'),
  leader(id: 2, title: 'Líder'),
  supervisor(id: 3, title: 'Supervisor');

  const Role({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;
  @override
  int compareTo(Role other) => id - other.id;
}
