import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount, RouterLinkStub, shallowMount, VueWrapper } from '@vue/test-utils'
import Navbar from '../Navbar.vue'
import User from '../User.vue'
import { createTestingPinia } from '@pinia/testing'

describe('Navbar.vue', () => {
  it('has router links', () => {
    const wrapper = shallowMount(Navbar, {
      global: {
        stubs: {
          RouterLink: RouterLinkStub,
        },
        plugins: [createTestingPinia({ createSpy: vi.fn})],
      },
    });
    const paths: string[] = ['/', '/about'];
    wrapper.findAllComponents(RouterLinkStub)
      .map((link: VueWrapper, index: number) => expect(link.props().to).toBe(paths[index]))
  })

  it('shows login button before auth', () => {
    const wrapper = shallowMount(Navbar, {
      global: {
        stubs: {
          RouterLink: RouterLinkStub,
        },
        plugins: [createTestingPinia({ createSpy: vi.fn})],
      },
    });
    expect(wrapper.find('#login').isVisible()).toBe(true)
    expect(wrapper.html()).not.toContain('Logout')
    expect(wrapper.findComponent(User).isVisible()).toBe(false)
  })

  it('shows logout button and user info after auth', () => {
    const wrapper = mount(Navbar, {
      global: {
        stubs: {
          RouterLink: RouterLinkStub,
        },
        plugins: [createTestingPinia({ createSpy: vi.fn, initialState: { auth: { isAuthenticated: true }} })],
      },
    });

    expect(wrapper.html()).not.toContain('Login')
    expect(wrapper.find('#logout').isVisible()).toBe(true)
    expect(wrapper.findComponent(User).isVisible()).toBe(true)
  })
})
