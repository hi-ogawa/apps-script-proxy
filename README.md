Apps Script Proxy

```
$ bash scripts.sh clone
$ for i in {1..10}; do bash scripts.sh clone; done
$ bash scripts.sh all-url > proxy-list.txt
$ bash scripts.sh test
FAIL
FAIL
FAIL
FAIL
FAIL
FAIL
SUCCESS
FAIL
FAIL
FAIL
:: SUMMARY >> 1/10 (SUCCESS/TOTAL) <<
```

References

- https://github.com/google/clasp
- https://developers.google.com/apps-script/guides/content
- https://developers.google.com/apps-script/concepts/manifests
- https://developers.google.com/apps-script/reference/url-fetch/url-fetch-app
