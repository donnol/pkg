
echo 'BEGIN.'

if [ -f "README.md" ] ; then
	rm -f README.md
fi

filecontent=`cat .git/COMMIT_EDITMSG`
echo $filecontent

echo '	'>>README.md
echo '====='>>README.md

echo "the last commit message : $filecontent">>README.md

echo '-----'>>README.md

git for-each-ref --sort='-*authordate' --format='%(tag)' 'refs/tags' | while read tag
do
	echo
	if [ $next ]; then
		echo '	'>>README.md
		echo '====='>>README.md
		echo '	'>>README.md
		echo '====='>>README.md
		eval "git show -s --oneline --format='%ad' $next>>README.md"
		echo '	'>>README.md
		echo '-----'>>README.md
	else
		echo '	'>>README.md
		echo '====='>>README.md
		echo '	'>>README.md
		echo '====='>>README.md
		echo 'No Tag'>>README.md
		echo '	'>>README.md
		echo '-----'>>README.md
	fi

	echo '	'>>README.md
	GIT_PAGER=cat git log --no-merges --date=short --encoding=UTF-8 --pretty=format:"- %ad (%an) %s \
		  <li><a href='https://github.com/fishedee/BakeWeb/commit/%H'>view commit</a></li>" $next...$tag>>README.md

	echo '	'>>README.md
	echo '-----'>>README.md
	next=$tag
	echo '	'>>README.md

done

echo 'DONE.'

git add -A
