// @flow
import { NativeModules } from "react-native";

export function isLoaded() {
  return typeof global.add === "function";
}

export function add(a, b) {
  return global.add(a, b);
}

if (!isLoaded()) {
  const result = NativeModules.SimpleJsi?.install();
  if (!result && !isLoaded())
    throw new Error("JSI bindings were not installed for: SimpleJsi Module");

  if (!isLoaded()) {
    throw new Error("JSI bindings were not installed for: SimpleJsi Module");
  }
}

const isTurboModuleEnabled = global.__turboModuleProxy != null;

const calculator = isTurboModuleEnabled
  ? require("./NativeCalculator").default
  : NativeModules.Calculator;

export default calculator;
