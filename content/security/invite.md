---
title: "Hacking my way into Hack The Box invitation"
date: 2020-05-05T12:50:24+05:30
draft: false
---
In order to join **Hack The Box**, one needs to capture the flag and the flag is the invitation code which will allow you to join them. This blog explains the steps I followed to capture the flag.  
1. The challenge says **You can find the invitation code in this page itself**, hence it was clear that the page needs to be inspected. Upon checking the console, I found the image of a skull, beside which it was written that the look look so a suspicious javascript file being loaded in the current page. Hence upon checking all the javascript files being loaded, I got hold of a file which had obfuscated js code.  
2. Obfuscated javascript code:  
```
eval(function(p,a,c,k,e,r){e=function(c){return c.toString(a)};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('0 3(){$.4({5:"6",7:"8",9:\'/b/c/d/e/f\',g:0(a){1.2(a)},h:0(a){1.2(a)}})}',18,18,'function|console|log|makeInviteCode|ajax|type|POST|dataType|json|url||api|invite|how|to|generate|success|error'.split('|'),0,{}))
```

3. Beautified the obfuscated js code to get this:-  
```
function makeInviteCode() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: '/api/invite/how/to/generate',
        success: function(a) {
            console.log(a)
        },
        error: function(a) {
            console.log(a)
        }
    })
}
```

4. Ran this `makeInviteCode` method on the console of the website and got a ROT13 encrypted payload:  
*Va beqre gb trarengr gur vaivgr pbqr, znxr n CBFG erdhrfg gb /ncv/vaivgr/trarengr*

5. Decrypting the ROT13 encrypted payload got me this:
*"In order to generate the invite code, make a POST request to /api/invite/generate"*	

6. Now in order to get the invite code I created the following method and ran it on the console:
```
function getInviteCode() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: '/api/invite/generate',
        success: function(a) {
            console.log(a)
        },
        error: function(a) {
            console.log(a)
        }
    })
}
```
then I got the following response:
**WVdMTlYtTU1CR0wtSVpMTlgtSEFKV0otQ0RaWFM=**  

It looked like it was base64 encoded.

7. Then I base64 decoded it and got me invitation code:
`QWNEH-FRGLK-MJKEB-ZIHGX-PYAHS`

It was simple yet interesting :)
