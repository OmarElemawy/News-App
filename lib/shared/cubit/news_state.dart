

abstract class NewsState {}

class InitialNewsState extends NewsState{}

class BottomNevNewsState extends NewsState{}

class GetBusinessNewsSuccessState extends NewsState{}

class GetDataLoadingNewsState extends NewsState{}

class GetBusinessNewsErrorState extends NewsState{
  final String error;

  GetBusinessNewsErrorState(this.error);
}

class GetHealthNewsSuccessState extends NewsState{}

class GetHealthLoadingNewsState extends NewsState{}

class GetHealthNewsErrorState extends NewsState{
  final String error;

  GetHealthNewsErrorState(this.error);
}

class GetSportsNewsSuccessState extends NewsState{}

class GetSportsLoadingNewsState extends NewsState{}

class GetSportsNewsErrorState extends NewsState{
  final String error;

  GetSportsNewsErrorState(this.error);
}

class ChangeModeAppNewsState extends NewsState{}

class GetSearchNewsSuccessState extends NewsState{}

class GetSearchLoadingNewsState extends NewsState{}

class GetSearchNewsErrorState extends NewsState{
  final String error;

  GetSearchNewsErrorState(this.error);
}
