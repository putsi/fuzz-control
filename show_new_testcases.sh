inotifywait -m /fuzz/tmpfs/afl_out/fuzzer01/queue/ -e create -e moved_to |
    while read path action file; do
        echo ""
        echo "### $(date) - FOUND NEW PATH"
        echo "### $file"
        echo "### "
        echo "### Start of testcase"
        echo ""
        cat -v $path/$file
        echo ""
        echo ""
        echo "### End of testcase"
    done

