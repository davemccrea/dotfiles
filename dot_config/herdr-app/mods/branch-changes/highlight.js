// Per-line syntax colouring for diff rows. Herdr's Editor highlights whole
// files but can't tint single diff lines, so this tokenises each line alone.
// Elixir heredocs are tracked across lines through `state`; docs show as
// strings, sigil heredocs (~H, ~p) as plain text.
// ponytail: other multi-line constructs (JS block comments, template literals)
// show as code; a real lexer if that gets in the way of reviews.

const ELIXIR = new Set("def defp defmodule defmacro defmacrop defstruct defimpl defprotocol defdelegate defguard defexception defoverridable do end fn if else unless case cond with when for in not and or try catch rescue after raise reraise throw receive send import alias require use quote unquote super nil true false".split(" "));
const JS = new Set("const let var function return if else for while do switch case break continue default new delete typeof instanceof in of class extends super this import export from as async await yield try catch finally throw null undefined true false void static get set".split(" "));

const LANGS = {
  elixir: { comment: /#.*/y, words: ELIXIR, atoms: true },
  js: { comment: /\/\/.*|\/\*.*?(?:\*\/|$)/y, words: JS, atoms: false },
  css: { comment: /\/\*.*?(?:\*\/|$)/y, words: new Set(), atoms: false },
};
const EXT = { ex: "elixir", exs: "elixir", heex: "elixir", eex: "elixir", js: "js", mjs: "js", cjs: "js", jsx: "js", ts: "js", tsx: "js", json: "js", css: "css" };

const STRING = /"(?:\\.|[^"\\])*"?|'(?:\\.|[^'\\])*'?|`(?:\\.|[^`\\])*`?/y;
const NUMBER = /\b\d[\d_]*(?:\.\d+)?\b/y;
const ATOM = /:[A-Za-z_][\w?!]*|[a-z_][\w?!]*:(?=\s)|@[a-z_]\w*/y;
const MODULE = /\b[A-Z]\w*(?:\.[A-Z]\w*)*/y;
const WORD = /\b[A-Za-z_$][\w$]*[?!]?/y;
const OTHER = /\s+|./y;

export const languageOf = (path) => LANGS[EXT[path.split(".").pop()]] ?? null;

// [{ text, kind }]: kind is a syntax colour name, or "" for plain text.
// `state` carries an open heredoc from one line to the next.
export function tokens(line, lang, state = {}) {
  if (!lang) return [{ text: line, kind: "" }];
  const quotes = lang.atoms ? (line.match(/"""|'''/g) ?? []).length : 0;
  if (state.heredoc !== undefined) {
    const kind = state.heredoc;
    if (quotes % 2) delete state.heredoc;
    return [{ text: line, kind }];
  }
  if (quotes % 2) state.heredoc = /~[A-Za-z]+(?:"""|''')/.test(line) ? "" : "string";
  const out = [];
  const push = (text, kind) => {
    const last = out[out.length - 1];
    if (last && last.kind === kind) last.text += text;
    else out.push({ text, kind });
  };
  let at = 0;
  const take = (re) => {
    re.lastIndex = at;
    const m = re.exec(line);
    if (m && m[0]) { at += m[0].length; return m[0]; }
    return null;
  };
  while (at < line.length) {
    let t;
    if ((t = take(lang.comment))) push(t, "comment");
    else if ((t = take(STRING))) push(t, "string");
    else if (lang.atoms && (t = take(ATOM))) push(t, "constant");
    else if ((t = take(NUMBER))) push(t, "number");
    else if ((t = take(MODULE))) push(t, "type");
    else if ((t = take(WORD))) push(t, lang.words.has(t) ? "keyword" : line[at] === "(" ? "function" : "");
    else push(take(OTHER), "");
  }
  return out;
}

// Same colours as Herdr's file viewer.
export const colours = (t) => ({ keyword: t.ansi5, string: t.ansi2, comment: t.dim, function: t.ansi4, type: t.ansi3, number: t.ansi1, constant: t.ansi6 });
