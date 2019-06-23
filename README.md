# simpleMVVM
Study  MVVM

![MVVM](https://user-images.githubusercontent.com/34600200/59975462-bbfc2900-95f2-11e9-860b-94c3d8c9a968.png)

Model-ViewModel間はDependency Injection(以下DI)を用いてプロトコルに依存する。

## 問題点らしきもの
ViewModelConstructorにViewのObservableを渡しているが、このまま監視したいものが増えていったらinit引数がとんでもないことになる。
ViewModel-View間もDIを使ってプロトコル依存にしたい。（それってもはやMVVMなのか...? Clean Architecture? ）

## 動き

<img width="350" src="https://user-images.githubusercontent.com/34600200/59975006-1d6dc900-95ee-11e9-980f-b6765d137682.gif">
