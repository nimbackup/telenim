# :warning: Archived - please contribute to https://github.com/nimgram/nimgram instead



# telenim
This library (will be) a high-level TDLib wrapper for Nim.

As of now it's in a pretty rough shape, but some stuff already works:
- [x] Parsing TDLib TL schema objects into Nim types (see ``src/tdgen.nim``)
- [x] Using TDLib asynchronously (it runs in a separate thread)
- [ ] Parsing TDLib TL schema functions into Nim procedures
- [ ] Helper procedures for accessing common fields of TDLib objects
- [ ] High-level hand-written procedures for common bot operations

To run the ``examples/userbot.nim`` example, you need:
- Config file in examples/config.json
```json
{
  "phone": "+123124214",
  "password": "2fa password if you have one",
  "api_id": "api id of your telegram app",
  "api_hash": "api hash"
}
```
- Compile with ``--threads:on`` (``config.nims`` in ``examples`` folder already does that)
- ``libtdjson.so`` (or ``libtdjson.so.1.6.0``) in ``lib`` folder.
If you want to run telenim with another TDLib version, you'll have to run tdgen.nim on td_api.tl from that TDLib version and then (for now) you also have to modify the generated ``tdlib_types.nim`` file to fix some invalid code.
- ``mathexpr`` Nim library (for now it's just used as an example command for the userbot)
