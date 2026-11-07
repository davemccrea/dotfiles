// Cmd-Enter: show the agent that has waited longest for you, blocked before done; nothing waiting, a toast.
import { View, div } from "gpui-kit";
import { agents, run, notify, props, closeOverlay } from "herdr";

const RANK = { blocked: 0, done: 1 };

export default class NextWaiting extends View {
  init(_props, cx) {
    const next = agents()
      .filter((a) => a.status in RANK && !a.focused)
      .sort((a, b) => RANK[a.status] - RANK[b.status] || a.seq - b.seq)[0];
    if (next) run("agent.focus", { terminal: next.address });
    else notify({ title: "No agent is waiting for you" });
    cx.timer.after(0, () => closeOverlay(props().overlay));
  }

  render() {
    return div();
  }
}
