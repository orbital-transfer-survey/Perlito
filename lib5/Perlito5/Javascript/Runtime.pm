# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
our $MATCH = Perlito5::Match->new();
package main;
use v5;
package Perlito5::Javascript::Runtime;
sub Perlito5::Javascript::Runtime::emit_javascript {
    return ('//' . chr(10) . '// lib/Perlito5/Javascript/Runtime.js' . chr(10) . '//' . chr(10) . '// Runtime for "Perlito" Perl5-in-Javascript' . chr(10) . '//' . chr(10) . '// AUTHORS' . chr(10) . '//' . chr(10) . '// Flavio Soibelmann Glock  fglock@gmail.com' . chr(10) . '//' . chr(10) . '// COPYRIGHT' . chr(10) . '//' . chr(10) . '// Copyright 2009, 2010, 2011, 2012 by Flavio Soibelmann Glock and others.' . chr(10) . '//' . chr(10) . '// This program is free software; you can redistribute it and/or modify it' . chr(10) . '// under the same terms as Perl itself.' . chr(10) . '//' . chr(10) . '// See http://www.perl.com/perl/misc/Artistic.html' . chr(10) . chr(10) . 'var isNode = typeof require != "undefined";' . chr(10) . chr(10) . 'if (typeof NAMESPACE !== "object") {' . chr(10) . '    NAMESPACE = {};' . chr(10) . '    LOCAL = [];' . chr(10) . chr(10) . '    var universal = function () {};' . chr(10) . '    NAMESPACE.UNIVERSAL = new universal();' . chr(10) . '    NAMESPACE.UNIVERSAL._ref_ = "UNIVERSAL";' . chr(10) . '    NAMESPACE.UNIVERSAL.isa = function (List__) {' . chr(10) . '        // TODO - use @ISA' . chr(10) . '        return List__[0]._class_._ref_ == List__[1]' . chr(10) . '    };' . chr(10) . '    NAMESPACE.UNIVERSAL.can = function (List__) {' . chr(10) . '        var o = List__[0];' . chr(10) . '        var s = List__[1];' . chr(10) . '        if ( s.indexOf("::") == -1 ) {' . chr(10) . '            // TODO - use _method_lookup_' . chr(10) . '            return o._class_[s]' . chr(10) . '        }' . chr(10) . '        var c = s.split("::");' . chr(10) . '        s = c.pop(); ' . chr(10) . '        // TODO - use _method_lookup_' . chr(10) . '        return _method_lookup_(s, c.join("::"), {});' . chr(10) . '    };' . chr(10) . '    NAMESPACE.UNIVERSAL.DOES = NAMESPACE.UNIVERSAL.can;' . chr(10) . chr(10) . '    var core = function () {};' . chr(10) . '    NAMESPACE["CORE"] = new core();' . chr(10) . '    NAMESPACE["CORE"]._ref_ = "CORE";' . chr(10) . chr(10) . '    var core_global = function () {};' . chr(10) . '    core_global.prototype = NAMESPACE.CORE;' . chr(10) . '    NAMESPACE["CORE::GLOBAL"] = new core_global();' . chr(10) . '    NAMESPACE["CORE::GLOBAL"]._ref_ = "CORE::GLOBAL";' . chr(10) . chr(10) . '    p5_error = function (v) {' . chr(10) . '        this.v = v;' . chr(10) . '    };' . chr(10) . '    p5_error.prototype = Error;' . chr(10) . '}' . chr(10) . chr(10) . 'function make_package(pkg_name) {' . chr(10) . '    if (!NAMESPACE.hasOwnProperty(pkg_name)) {' . chr(10) . '        var tmp = function () {};' . chr(10) . '        tmp.prototype = NAMESPACE["CORE::GLOBAL"];' . chr(10) . '        NAMESPACE[pkg_name] = new tmp();' . chr(10) . '        NAMESPACE[pkg_name]._ref_ = pkg_name;' . chr(10) . '        NAMESPACE[pkg_name]._class_ = NAMESPACE[pkg_name];  // XXX memory leak' . chr(10) . chr(10) . '        // TODO - add the other package global variables' . chr(10) . '        NAMESPACE[pkg_name]["List_ISA"] = [];' . chr(10) . '        NAMESPACE[pkg_name]["v_a"] = null;' . chr(10) . '        NAMESPACE[pkg_name]["v_b"] = null;' . chr(10) . '        NAMESPACE[pkg_name]["v__"] = null;' . chr(10) . '    }' . chr(10) . '    return NAMESPACE[pkg_name];' . chr(10) . '}' . chr(10) . chr(10) . 'function _method_lookup_(method, class_name, seen) {' . chr(10) . '    // default mro' . chr(10) . '    c = NAMESPACE[class_name];' . chr(10) . '    if ( c.hasOwnProperty(method) ) {' . chr(10) . '        return c[method]' . chr(10) . '    }' . chr(10) . '    var isa = c.List_ISA;' . chr(10) . '    for (var i = 0; i < isa.length; i++) {' . chr(10) . '        if (!seen[isa[i]]) {' . chr(10) . '            var m = _method_lookup_(method, isa[i]);' . chr(10) . '            if (m) {' . chr(10) . '                return m ' . chr(10) . '            }' . chr(10) . '            seen[isa[i]]++;' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    // TODO - AUTOLOAD' . chr(10) . '}' . chr(10) . chr(10) . 'function p5cal(invocant, method, list) {' . chr(10) . '    // TODO - method can have an optional namespace' . chr(10) . '    list.unshift(invocant);' . chr(10) . '    if ( invocant._class_.hasOwnProperty(method) ) {' . chr(10) . '        return invocant._class_[method](list) ' . chr(10) . '    }' . chr(10) . '    var m = _method_lookup_(method, invocant._class_._ref_, {});' . chr(10) . '    if (m) {' . chr(10) . '        return m(list)' . chr(10) . '    }' . chr(10) . '    if ( NAMESPACE.UNIVERSAL.hasOwnProperty(method) ) {' . chr(10) . '        return NAMESPACE.UNIVERSAL[method](list) ' . chr(10) . '    }' . chr(10) . '    // TODO - cache the methods that were already looked up' . chr(10) . '    NAMESPACE.CORE.die(["method not found: ", method, " in class ", invocant._ref_]);' . chr(10) . '}' . chr(10) . chr(10) . 'make_package("main");' . chr(10) . 'NAMESPACE["main"]["v_@"] = [];   // $@' . chr(10) . chr(10) . 'make_package("Perlito5");' . chr(10) . 'make_package("Perlito5::IO");' . chr(10) . 'make_package("Perlito5::Runtime");' . chr(10) . 'make_package("Perlito5::Grammar");' . chr(10) . chr(10) . 'function make_sub(pkg_name, sub_name, func) {' . chr(10) . '    NAMESPACE[pkg_name][sub_name] = func;' . chr(10) . '}' . chr(10) . chr(10) . 'function set_local(namespace, name, sigil) {' . chr(10) . '    var v = name;' . chr(10) . '    if (sigil == "$") {' . chr(10) . '        v = "v_"+name;' . chr(10) . '    }' . chr(10) . '    LOCAL.push([namespace, v, namespace[v]]);' . chr(10) . '}' . chr(10) . chr(10) . 'function cleanup_local(idx, value) {' . chr(10) . '    while (LOCAL.length > idx) {' . chr(10) . '        l = LOCAL.pop();' . chr(10) . '        l[0][l[1]] = l[2];' . chr(10) . '    }' . chr(10) . '    return value;' . chr(10) . '}' . chr(10) . chr(10) . 'if (isNode) {' . chr(10) . '    List_ARGV = process.argv.splice(2);' . chr(10) . '} else if (typeof arguments === "object") {' . chr(10) . '    List_ARGV = arguments;' . chr(10) . '}' . chr(10) . chr(10) . 'function HashRef(o) {' . chr(10) . '    this._hash_ = o;' . chr(10) . '    this._ref_ = "HASH";' . chr(10) . '    this.bool = function() { return 1 };' . chr(10) . '}' . chr(10) . chr(10) . 'function ArrayRef(o) {' . chr(10) . '    this._array_ = o;' . chr(10) . '    this._ref_ = "ARRAY";' . chr(10) . '    this.bool = function() { return 1 };' . chr(10) . '}' . chr(10) . chr(10) . 'function ScalarRef(o) {' . chr(10) . '    this._scalar_ = o;' . chr(10) . '    this._ref_ = "SCALAR";' . chr(10) . '    this.bool = function() { return 1 };' . chr(10) . '}' . chr(10) . chr(10) . 'if (isNode) {' . chr(10) . '    var fs = require("fs");' . chr(10) . '    make_sub("Perlito5::IO", "slurp", function(List__) {' . chr(10) . '        return fs.readFileSync(List__[0],"utf8");' . chr(10) . '    });' . chr(10) . '} else {' . chr(10) . '    make_sub("Perlito5::IO", "slurp", function(List__) {' . chr(10) . '        var filename = List__[0];' . chr(10) . '        if (typeof readFile == "function") {' . chr(10) . '            return readFile(filename);' . chr(10) . '        }' . chr(10) . '        if (typeof read == "function") {' . chr(10) . '            // v8' . chr(10) . '            return read(filename);' . chr(10) . '        }' . chr(10) . '        NAMESPACE.CORE.die(["Perlito5::IO::slurp() not implemented"]);' . chr(10) . '    });' . chr(10) . '}' . chr(10) . chr(10) . 'interpolate_array = function() {' . chr(10) . '    var res = [];' . chr(10) . '    for (i = 0; i < arguments.length; i++) {' . chr(10) . '        var o = arguments[i];' . chr(10) . '        if  (  o == null' . chr(10) . '            || o._class_    // perl5 blessed reference' . chr(10) . '            || o._ref_      // perl5 un-blessed reference' . chr(10) . '            )' . chr(10) . '        {' . chr(10) . '            res.push(o);' . chr(10) . '        }' . chr(10) . '        else if (o instanceof Array) {' . chr(10) . '            // perl5 array' . chr(10) . '            for (j = 0; j < o.length; j++) {' . chr(10) . '                res.push(o[j]);' . chr(10) . '            }' . chr(10) . '        }' . chr(10) . '        else if (typeof o === "object") {' . chr(10) . '            // perl5 hash' . chr(10) . '            for(var j in o) {' . chr(10) . '                if (o.hasOwnProperty(j)) {' . chr(10) . '                    res.push(j);' . chr(10) . '                    res.push(o[j]);' . chr(10) . '                }' . chr(10) . '            }' . chr(10) . '        }' . chr(10) . '        else {' . chr(10) . '            // non-ref' . chr(10) . '            res.push(o);' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    return res;' . chr(10) . '};' . chr(10) . chr(10) . 'array_to_hash = function(a) {' . chr(10) . '    var res = {};' . chr(10) . '    for (i = 0; i < a.length; i+=2) {' . chr(10) . '        res[p5str(a[i])] = a[i+1];' . chr(10) . '    }' . chr(10) . '    return res;' . chr(10) . '};' . chr(10) . chr(10) . 'p5str = function(o) {' . chr(10) . '    if (o == null) {' . chr(10) . '        return "";' . chr(10) . '    }' . chr(10) . '    if (typeof o === "object" && (o instanceof Array)) {' . chr(10) . '        var out = [];' . chr(10) . '        for (var i = 0; i < o.length; i++) {' . chr(10) . '            out.push(p5str(o[i]));' . chr(10) . '        }' . chr(10) . '        return out.join(" ");' . chr(10) . '    }' . chr(10) . '    if (typeof o.string === "function") {' . chr(10) . '        return o.string();' . chr(10) . '    }' . chr(10) . '    if (typeof o !== "string") {' . chr(10) . '        return "" + o;' . chr(10) . '    }' . chr(10) . '    return o;' . chr(10) . '};' . chr(10) . chr(10) . 'num = function(o) {' . chr(10) . '    if (o == null) {' . chr(10) . '        return 0;' . chr(10) . '    }' . chr(10) . '    if (typeof o === "object" && (o instanceof Array)) {' . chr(10) . '        return o.length;' . chr(10) . '    }' . chr(10) . '    if (typeof o.num === "function") {' . chr(10) . '        return o.num();' . chr(10) . '    }' . chr(10) . '    if (typeof o !== "number") {' . chr(10) . '        return parseFloat(p5str(o));' . chr(10) . '    }' . chr(10) . '    return o;' . chr(10) . '};' . chr(10) . chr(10) . 'add = function(o1, o2) {' . chr(10) . '    return num(o1) + num(o2)' . chr(10) . '};' . chr(10) . chr(10) . 'bool = function(o) {' . chr(10) . '    if (o == null) {' . chr(10) . '        return o;' . chr(10) . '    }' . chr(10) . '    if (typeof o === "boolean") {' . chr(10) . '        return o;' . chr(10) . '    }' . chr(10) . '    if (typeof o === "number") {' . chr(10) . '        return o;' . chr(10) . '    }' . chr(10) . '    if (typeof o === "string") {' . chr(10) . '        return o != "" && o != "0";' . chr(10) . '    }' . chr(10) . '    if (typeof o.bool === "function") {' . chr(10) . '        return o.bool();' . chr(10) . '    }' . chr(10) . '    if (typeof o.length === "number") {' . chr(10) . '        return o.length;' . chr(10) . '    }' . chr(10) . '    for (var i in o) {' . chr(10) . '        return true;' . chr(10) . '    }' . chr(10) . '    return false;' . chr(10) . '};' . chr(10) . chr(10) . 'and = function(a, fb) {' . chr(10) . '    if (bool(a)) {' . chr(10) . '        return fb();' . chr(10) . '    }' . chr(10) . '    return a;' . chr(10) . '};' . chr(10) . chr(10) . 'or = function(a, fb) {' . chr(10) . '    if (bool(a)) {' . chr(10) . '        return a;' . chr(10) . '    }' . chr(10) . '    return fb();' . chr(10) . '};' . chr(10) . chr(10) . 'defined_or = function(a, fb) {' . chr(10) . '    if (a == null) {' . chr(10) . '        return fb();' . chr(10) . '    }' . chr(10) . '    return a;' . chr(10) . '};' . chr(10) . chr(10) . 'str_replicate = function(o, n) {' . chr(10) . '    n = num(n);' . chr(10) . '    return n ? Array(n + 1).join(o) : "";' . chr(10) . '};' . chr(10) . chr(10) . 'p5for = function(namespace, func, args) {' . chr(10) . '    var v_old = namespace["v__"];' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        namespace["v__"] = args[i];' . chr(10) . '        func()' . chr(10) . '    }' . chr(10) . '    namespace["v__"] = v_old;' . chr(10) . '};' . chr(10) . chr(10) . 'p5map = function(namespace, func, args) {' . chr(10) . '    var v_old = namespace["v__"];' . chr(10) . '    var out = [];' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        namespace["v__"] = args[i];' . chr(10) . '        out.push(func())' . chr(10) . '    }' . chr(10) . '    namespace["v__"] = v_old;' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'p5grep = function(namespace, func, args) {' . chr(10) . '    var v_old = namespace["v__"];' . chr(10) . '    var out = [];' . chr(10) . '    for(var i = 0; i < args.length; i++) {' . chr(10) . '        namespace["v__"] = args[i];' . chr(10) . '        if (bool(func())) {' . chr(10) . '            out.push(args[i])' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    namespace["v__"] = v_old;' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'p5sort = function(namespace, func, args) {' . chr(10) . '    var a_old = namespace["v_a"];' . chr(10) . '    var b_old = namespace["v_b"];' . chr(10) . '    var out = ' . chr(10) . '        func == null' . chr(10) . '        ? args.sort()' . chr(10) . '        : args.sort(' . chr(10) . '            function(a, b) {' . chr(10) . '                namespace["v_a"] = a;' . chr(10) . '                namespace["v_b"] = b;' . chr(10) . '                return func();' . chr(10) . '            }' . chr(10) . '        );' . chr(10) . '    namespace["v_a"] = a_old;' . chr(10) . '    namespace["v_b"] = b_old;' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'function perl5_to_js( source, namespace, var_env_js ) {' . chr(10) . '    // say( "source: [" + source + "]" );' . chr(10) . chr(10) . '    var strict_old = NAMESPACE["Perlito5"].v_STRICT;' . chr(10) . '    var var_env_js_old = NAMESPACE["Perlito5"].v_VAR;' . chr(10) . '    NAMESPACE["Perlito5"].v_VAR = var_env_js;' . chr(10) . chr(10) . '    var namespace_old = NAMESPACE["Perlito5"].v_PKG_NAME;' . chr(10) . '    NAMESPACE["Perlito5"].v_PKG_NAME = namespace;' . chr(10) . chr(10) . '    match = p5cal(NAMESPACE["Perlito5::Grammar"], "exp_stmts", [source, 0]);' . chr(10) . chr(10) . '    if ( !match._hash_.bool || match._hash_.to != source.length ) {' . chr(10) . '        CORE.die(["Syntax error in eval near pos ", match._hash_.to]);' . chr(10) . '    }' . chr(10) . chr(10) . '    ast = NAMESPACE.CORE.bless([' . chr(10) . '        new HashRef({' . chr(10) . '            block:  NAMESPACE.CORE.bless([' . chr(10) . '                        new HashRef({' . chr(10) . '                            stmts:   p5cal(match, "flat", []),' . chr(10) . '                        }),' . chr(10) . '                        NAMESPACE["Perlito5::AST::Lit::Block"]' . chr(10) . '                    ]),' . chr(10) . '        }),' . chr(10) . '        NAMESPACE["Perlito5::AST::Do"]' . chr(10) . '    ]);' . chr(10) . chr(10) . '    // CORE.say( "ast: [" + perl(ast) + "]" );' . chr(10) . '    js_code = p5cal(ast, "emit_javascript", []);' . chr(10) . '    // CORE.say( "js-source: [" + js_code + "]" );' . chr(10) . chr(10) . '    NAMESPACE["Perlito5"].v_PKG_NAME = namespace_old;' . chr(10) . '    NAMESPACE["Perlito5"].v_VAR      = var_env_js_old;' . chr(10) . '    NAMESPACE["Perlito5"].v_STRICT = strict_old;' . chr(10) . '    return js_code;' . chr(10) . '}' . chr(10))
};
1;

1;
