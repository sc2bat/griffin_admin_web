enum SignStatus {
  signSuccess,
  signFail,
  isSignedIn,
  isNotSignedIn,
}

enum BookStatus {
  inProgress,
  completed,
  cancelled,
  error,
}

enum PayStatus {
  pending,
  inProgress,
  completed,
  cancelled,
  error,
}

BookStatus convertToBookStatus(int bookStatus) {
  switch (bookStatus) {
    case 1:
      return BookStatus.inProgress;
    case 2:
      return BookStatus.completed;
    case 4:
      return BookStatus.cancelled;
    default:
      return BookStatus.error;
  }
}

PayStatus convertToPayStatus(int payStatus) {
  switch (payStatus) {
    case 0:
      return PayStatus.pending;
    case 1:
      return PayStatus.inProgress;
    case 3:
      return PayStatus.completed;
    case 4:
      return PayStatus.cancelled;
    default:
      return PayStatus.error;
  }
}
