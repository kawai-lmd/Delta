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

`pip show ultralytics`とやったときの挙動が上記。

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