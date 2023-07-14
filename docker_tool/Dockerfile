FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

# os上での日本語のエラー防止
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive

# condaのpythonが使われるようにする
ENV PATH=/opt/conda/bin:$PATH

# Conda Virtual Environment name
ENV CVE=env1

# あると便利なパッケージたちのインストール．
RUN apt-get update --fix-missing \
 && apt-get install -y wget bzip2 ca-certificates zip unzip nkf \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    fonts-takao \
    python3-opencv libopencv-dev

# conda(miniconda)のインストール
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
 && /bin/bash ~/miniconda.sh -b -p /opt/conda \
 && rm ~/miniconda.sh \
 && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
 && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

# condaの仮想環境を構築．さらにdocker run後に自動でactivateするように .bashrc に設定を追記．
# バージョンの参考: https://pytorch.org/get-started/previous-versions/
RUN . /opt/conda/bin/activate \
 && conda create -n $CVE python=3.9 \
 && conda activate $CVE \
 && pip install numpy matplotlib tqdm \
 && pip install pandas seaborn scikit-learn \
 && pip install jupyter \
 && echo "conda activate ${CVE}" >> ~/.bashrc


####################################################################################################
## ビルド用コマンド．
## 端末で実行する．-tの後ろがimage名．-fの後ろがdockerfileのパス．末尾がdockerfileのあるディレクトリのパス
##
## $ docker build -t abn_cuda11.1_pytorch1.8.2 -f /local_home/naoki_local/dockerfiles/ABN_cuda11.1_pytorch1.8.2 /local_home/naoki_local/dockerfiles/
## $ docker build -t abn_cuda11.1_pytorch1.8.2 $PWD
####################################################################################################
