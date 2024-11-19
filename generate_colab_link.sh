#!/bin/bash

# 設置 GitHub 倉庫基本資訊
GITHUB_USER="LiuYuWei"
GITHUB_REPO="llm-colab-application"

# 檢查是否有 .ipynb 文件，排除掉 -checkpoint.ipynb 的檔案
NOTEBOOK_FILES=$(find . -name "*.ipynb" -type f | grep -v "\-checkpoint.ipynb")

if [ -z "$NOTEBOOK_FILES" ]; then
  echo "沒有找到任何 .ipynb 文件。"
  exit 1
fi

# 初始化 README 文件
if [ ! -f "README.md" ]; then
  echo "# $GITHUB_REPO" > README.md
  echo -e "\n## Google Colab 連結\n" >> README.md
else
  # 清除 README 中舊的 Colab 連結部分
  sed -i '' '/## Google Colab 連結/,$d' README.md
  echo -e "\n## Google Colab 連結\n\n" >> README.md
fi

# 對每個 .ipynb 文件生成 Colab 連結並添加到 README 文件中
for FILE in $NOTEBOOK_FILES; do
  # 提取 Notebook 文件名
  NOTEBOOK_NAME=$(basename "$FILE")
  
  # 生成 Colab 連結
  COLAB_LINK="https://colab.research.google.com/github/$GITHUB_USER/$GITHUB_REPO/blob/main/$NOTEBOOK_NAME"
  
  # 添加到 README
  echo -e "- $NOTEBOOK_NAME\n\n  [$NOTEBOOK_NAME]($COLAB_LINK)\n\n" >> README.md
done

echo "所有 Colab 連結已生成並添加到 README.md。"
