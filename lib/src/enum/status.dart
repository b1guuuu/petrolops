enum Status implements Comparable<Status> {
  open(id: 1, title: 'ABERTO'),
  inProgress(id: 2, title: 'ANDAMENTO'),
  validation(id: 3, title: 'VALIDAÇÃO'),
  finished(id: 4, title: 'CONCLUÍDO'),
  canceled(id: 5, title: 'CANCELADO');

  const Status({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;
  @override
  int compareTo(Status other) => id - other.id;
}
