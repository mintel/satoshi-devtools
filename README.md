# satoshi-devtools

Image containing approved versions of tools used with apps running on Mintel's Satoshi platform.

## Usage

Use in your app's Dockerfile as follows:

```dockerfile
COPY --from=mintel/satoshi-devtools:$VERSION /usr/local/bin/* /usr/local/bin/
```
