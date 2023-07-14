# Python環境
参考: \
https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd

かなりわかりやすく環境比較が行われているのは上記のサイト。
## 1. pip

参考：\
https://www.python-izm.com/tips/pip/ \
https://qiita.com/john-rocky/items/40fbb459a43e1c02459e \
https://note.nkmk.me/python-package-version/

### 1.1.そもそもpipがあるか確認
```python
python -m pip -V
```
または、
```python
python3 -m pip -V
```
とターミナルに入力することで確認できる。例えば、以下のような返り値くれば正常に存在している。

```zsh
pip 23.0.1 from /Users/masato/miniconda3/lib/python3.10/site-packages/pip (python 3.10)
```

### 1.2.あとはyolo(ultralytics)をインストールするだけ
```zsh
pip install ultralytics
```
### 1.3.確認
```zsh
pip list
pip freeze
pip show ultralytics
```
のいずれかを行い、ultralyticsが入っているかを確認すればOK。
```zsh
Name: ultralytics
Version: 8.0.91
Summary: Ultralytics YOLOv8
Home-page: https://github.com/ultralytics/ultralytics
Author: Ultralytics
Author-email: hello@ultralytics.com
License: AGPL-3.0
Location: /Users/masato/miniconda3/lib/python3.10/site-packages
Requires: matplotlib, opencv-python, pandas, Pillow, psutil, PyYAML, requests, scipy, seaborn, sentry-sdk, thop, torch, torchvision, tqdm
Required-by:
```

`pip show ultralytics`とやったときの挙動が上記。すでにminiconda環境をインストールしているためminiconda3配下にパッケージが管理されていることがわかる。

## 2. conda(推奨)
参考: \
https://www.javadrive.jp/python/install/index5.html (Anacondaはこのやり方でinstallしてね)\
https://qiita.com/ozaki_physics/items/985188feb92570e5b82d

### 2.1.推奨理由
あるAというコードを実行するときに必要なパッケージ群とBというコードを実行するときに必要なパッケージ群が異なるときにそれらを別々に管理するための仮想環境(パッケージの箱)を作成して整理することができるため。たとえばマクドナルド(仮想環境A)ではハンバーガーやポテトなどの商品が提供されているが、ユーザーが他の商品も欲しいとおもってケーキやカヌレを追加し始めるとマクドナルドのパッケージがどんどん荒れるので、それを避けるためにケーキやカヌレを食べたい場合はまた別にスイーツ屋さん(仮想環境B)を用意して管理をしやすくしている。

### 2.2.確認
仮想環境を確認
```zsh
conda info -e
```
河合の場合は以下の通りになる。

```
# conda environments:
#
base                  *  /Users/masato/miniconda3
0603                     /Users/masato/miniconda3/envs/0603
RL                       /Users/masato/miniconda3/envs/RL
biz-training             /Users/masato/miniconda3/envs/biz-training
demo                     /Users/masato/miniconda3/envs/demo
demo_anotate             /Users/masato/miniconda3/envs/demo_anotate
lstm                     /Users/masato/miniconda3/envs/lstm
movie_classification     /Users/masato/miniconda3/envs/movie_classification
vae                      /Users/masato/miniconda3/envs/vae
yolo                     /Users/masato/miniconda3/envs/yolo
```

baseが基本的に何でもできるように用意してあり、yoloはyoloのコードを実行するときに使い、lstmは時系列分析をしようとしたときに用意したもの。

## 3. pipenv
参考: \
https://qiita.com/y-tsutsu/items/54c10e0b2c6b565c887a \
https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd \
https://zenn.dev/nekoallergy/articles/py-env-pipenv01

>新しいプロジェクトで仮想環境を作りたければpipenv installとするだけ、git cloneしてきたプロジェクトに置いてあったPipfileを読み込むときもpipenv installとするだけ、pipの代わりに使うときもpipenv install <package-name>とpipをpipenvに置き換えるだけ。大変わかりやすい。(引用：https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd)

### 3.1.演習
[こちらの記事](https://zenn.dev/nekoallergy/articles/py-env-pipenv01)の演習がかなりわかりやすいのでもしもpipenv環境を選択するのであればこれに沿って環境を構築してみることをおすすめする。(他のpip, condaでも同じ環境を作れるかのテストをやってもらうのもありかな、独り言です。)

## 4. docker環境(簡易説明)

dockerをとりあえず使って見る場合は、使いたいドッカーイメージを[docker hub](https://hub.docker.com/)から持ってくる。今回はyoloを扱うため[ultralyticsのページ](https://hub.docker.com/r/ultralytics/ultralytics)を参照する。開けばわかるが、Docker Pull Commandという部分のすぐ下にコードが記載されており、それがイメージをローカルに持ってくるコマンドである。

```bash
docker pull ultralytics/ultralytics
```

そして、docker imageを起動する場合、まずは持ってきたimageのIMAGE IDを確認する。
```
docker images

# REPOSITORY                                                    TAG            IMAGE ID       CREATED       SIZE
# ultralytics/ultralytics                                       latest-arm64   b05691b57d4f   2 weeks ago   1.55GB
# chat-love                                                     latest         02ac8d2e56c3   6 weeks ago   1.1GB
# 928590127839.dkr.ecr.ap-southeast-2.amazonaws.com/chat-love   latest         02ac8d2e56c3   6 weeks ago   1.1GB
```
持ってきたimageがb05691b57d4fであるため、その情報をもとに以下のコマンドを入力。

```
docker run -it \
--volume $PWD:/workdir \
--rm \
--workdir /workdir \
b05691b57d4f bash
```

詳しい説明はここではしないが、最小コマンドは以下
```
docker run -it b05691b57d4f bash
```
そこに、ローカルのデータをコンテナ内に反映させるvolumeコマンド、コンテナをexitしたときにコンテナを消去するrmコマンド、コンテナに入る際のディレクトリを指定するworkdirコマンドで細かい調整をしている。

文章化をすると、b05691b57d4fというイメージを実行してコンテナに入り込むが、その際にカレントディレクトリ($PWD)のデータをコンテナ内の/workdirというディレクトリに配置し、そこにアクセスする。コンテナから抜け出した際にそのコンテナの大きなデータがパソコンに残らないように消去を行う。

*興味がある人は/docker_toolという自分が使っているdockerのツールがあるので見てみてください。Dockerfileは細かく環境を作りたい場合に使用しています。例の場合、ubuntuのnvidiaでpythonが動くようなimageを作成しています。そして、run_server.shでは`bash run_server.sh`と打つだけで面倒なコマンド無しでコンテナの起動からその保存や削除ができるようにしています。

<!--
TODO docker環境について金子要請を達成。
1. dockerのありがたいところ
2. dockerをどのように使っているか(主に研究室)
3. dockerの簡易版使用方法
    1. docker build path/to/dockerfile
    2. docker run -it image_name
4. dockerの生成、起動テンプレート
    1. dockerfile
    2. run.sh
5. yolo環境の場合
    1. docker hubからイメージを探し出す
    2. イメージを起動する(コンテナ)
    3. コンテナ内でコードを実行してみる
    4. コンテナを終了する
-->