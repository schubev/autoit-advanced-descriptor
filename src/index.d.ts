export interface WindowDescription {
  readonly title?: string
  readonly className?: string
  readonly regexpTitle?: string
  readonly regexpClassName?: string
  readonly instance?: number
  readonly active?: boolean
  readonly last?: boolean
  readonly x?: number
  readonly y?: number
  readonly w?: number
  readonly h?: number
}

export function descriptor(windowDescription: WindowDescription): string
