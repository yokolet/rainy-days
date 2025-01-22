import { describe, it, expect, beforeEach, vi } from 'vitest'

import { RouterLinkStub, shallowMount, VueWrapper } from '@vue/test-utils';
import Navbar from '../Navbar.vue'
import User from '../User.vue';
import { useAuthStore } from '../../stores/auth';
import { createTestingPinia } from '@pinia/testing';

const createWrapper = () => shallowMount(Navbar ,{
  global: {
    stubs: {
      RouterLink: RouterLinkStub,
    },
    plugins: [createTestingPinia({ stubActions: false, createSpy: vi.fn})],
  },
});
let wrapper = createWrapper();

describe('Navbar.vue', () => {
  beforeEach(() => {
    wrapper = createWrapper();
  })

  it('has router links', () => {
    const paths: string[] = ['/', '/about'];
    wrapper.findAllComponents(RouterLinkStub)
      .map((link: VueWrapper, index: number) => expect(link.props().to).toBe(paths[index]))
  })

  it('shows login button before auth', () => {
    expect(wrapper.find('#login').isVisible()).toBe(true)
    expect(wrapper.html()).not.toContain('Logout')
    expect(wrapper.findComponent(User).isVisible()).toBe(false)
  })

  it('shows logout button and user info after auth', async () => {
    await wrapper.find('#login').trigger('click')

    expect(wrapper.html()).not.toContain('Login')
    expect(wrapper.find('#logout').isVisible()).toBe(true)
    expect(wrapper.findComponent(User).isVisible()).toBe(true)
  })
})
