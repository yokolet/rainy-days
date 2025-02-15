import { useDateFormat } from '@vueuse/core'

export const formatDate = (date: string) =>
  useDateFormat(new Date(date), 'YYYY-MM-DD')

export const shortName = (email: string) => {
  const name = email.split('@')[0]
  return name.length <= 6 ? name.slice(0, 6) : `${name.slice(0, 6)}...`
}

export const longerName = (email: string) =>
  email.split('@')[0]
