export type WindowDescription = {
  title?: string
  className?: string
  regexpTitle?: string
  regexpClassName?: string
  instance?: number
  active?: boolean
  last?: boolean
  x?: number
  y?: number
  w?: number
  h?: number
}

export function descriptor(windowDescription: WindowDescription): string
