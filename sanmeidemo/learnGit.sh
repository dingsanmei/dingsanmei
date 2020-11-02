mkdir  /Users/teisanbi/Documents/learngit  #创建版本库
cd learngit
pwd #当前目录
git init # 将该目录变成可供 git 管理的版本库(当前一定要在learnGit目录下)
创建文件.txt(纯文本文件)
git add "dsm.txt"#可以 add 多个文件
git commit -m ”提交说明“#将多次 add 的文件一次 commit
git status#查看仓库当前状态，是否有修改过的文件
git diff  readme.txt #查看文件之前修改
git log #查看修改历史   (简略版 git log --pretty=oneline)  按 q 键退出 git log 浏览
git reset --HEAD^回退到上一个版本   HEAD^^ HEAD~100  /回退到上上个版本，前100个版本
git reset --hard 版本号 回退到之前那个版本
git reflog 查看所有版本的版本号
git diff HEAD -- readme.txt 可以查看提交的版本和当前工作区的版本的区别，在工作区的修改内容只有 add 之后进入暂存区才能被提交到仓库
git checkout -- readme.txt 可以撤销未提交的更改
git reset HEAD readme.txt 将提交到暂存区的修改退回到工作区
(add 了错误的内容，就先 reset 回退到工作区，然后用 checkout 撤销更改)

rm readme.txt 本地删除文件
然后 git rm readme.txt
git commit -m "rm readme.txt"  这样版本库也删掉了该文件
又或者是本地（工作区）误删文件，用 git checkout -- readme.txt 还原工作区删掉的文件


#关联github和本地仓库
/learngit下  git remote add origin git@github.com:dingsanmei/learngit1.git(github repo name)
关联错误的话
/learngit下 rm -rf .git
/learngit下 git init  #重新初始化
/learngit下 git add readme.txt
/learngit下 git commit -m "add new"
然后重新  git remote add origin git@github.com:dingsanmei/learngit1.git(github repo name)
没问题之后git push -u origin master 将本地内容 push 上
每次本地修改后add 再commit,再push

#创建远程库
在 github上建立一个新库
然后 git clone git@github.com:dingsanmei/gitskills.git   #ssh协议最快
将远程库克隆到本地
也可以 git clone https://github.com/dingsanmei/gitskills.git

#创建分支
git checkout -b dev #创建分支dev并切换到该分支
git branch 查看当前所在分支
git checkout main  #切换到 main 分支
在分支上做修改，然后 add commit 完成后
可以切换回main 分支，git merge dev，将分支的内容和 main 的内容合并
在分支上创建的文件必须 merge到 main 之后才能出现在 main 里面
merge 出现问题 按 esc 然后 输入:wq 回车

删除分支 git branch -d dev
切换分支可以用switch 替换 checkout
写完之后 add 然后 commit 然后 git push origin main推到远端

#解决冲突
当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。
解决冲突就是把Git合并失败的文件手动编辑为我们希望的内容，再提交。
用git log --graph命令可以看到分支合并图。

#分支管理
git merge --no-ff "merge with no ff" dev  可以保留分支历史
合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。
在实际开发中，我们应该按照几个基本原则进行分支管理：
首先，master分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；
那在哪干活呢？干活都在dev分支上，也就是说，dev分支是不稳定的，到某个时候，比如1.0版本发布时，再把dev分支合并到master上，在master分支发布1.0版本；
你和你的小伙伴们每个人都在dev分支上干活，每个人都有自己的分支，时不时地往dev分支上合并就可以了

#bug 修复
修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除；
当手头工作没有完成时，先把工作现场git stash一下，然后去修复bug，修复后，再git stash pop，回到工作现场；
在master分支上修复的bug，想要合并到当前dev分支，可以用git cherry-pick <commit>命令，把bug提交的修改“复制”到当前分支，避免重复劳动。
git reset --merge 回退到 merge 之前的版本
git cherry-pick <bug 修复commit后的序列号>

开发一个新feature，最好新建一个分支；
如果要丢弃一个没有被合并过的分支，可以通过git branch -D <name>强行删除。

多人协作的工作模式通常是这样：
首先，可以试图用git push origin <branch-name>推送自己的修改；
如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；
如果合并有冲突，则解决冲突，并在本地提交；
没有冲突或者解决掉冲突后，再用git push origin <branch-name>推送就能成功！
如果git pull提示no tracking information，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream-to <branch-name> origin/<branch-name>。
这就是多人协作的工作模式，一旦熟悉了，就非常简单。
查看远程库信息，使用git remote -v；
本地新建的分支如果不推送到远程，对其他人就是不可见的；
从本地推送分支，使用git push origin branch-name，如果推送失败，先用git pull抓取远程的新提交；
在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；
建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；
从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。










