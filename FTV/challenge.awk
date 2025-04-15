{
    split($1, prep, "=")
    split($2, data_rate, "=")
    split($3, ratio, "=")
    error = $6
    fatail = $9
    check = "check"
    key = "ddr_" prep[2] "_" data_rate[2] "_" ratio[2]
    print error> check
    if (fatal == 1) {
        interrupt[key]++
    } else if (fatal == 0 && error == 0) {
        pass[key]++
    } else {
        others[key]++
    }

    count[key]++
}

END {
    for (k in count) {
        printf "%s : %d\t|%d\t|%d\t|%d\t\n", k, count[k], pass[k]+0, interrupt[k]+0, others[k]+0
    }
} 

