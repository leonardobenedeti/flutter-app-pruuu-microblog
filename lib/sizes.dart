enum PruuuSize {
  s,
  l,
  m,
}

extension PruuuSizes on PruuuSize {
  double get value => _value();

  double _value() {
    switch (this) {
      case PruuuSize.s:
        return 8.0;
        break;
      case PruuuSize.m:
        return 16.0;
        break;
      case PruuuSize.l:
        return 32.0;
        break;
    }
  }
}
