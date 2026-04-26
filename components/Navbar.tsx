'use client';

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { usePathname } from 'next/navigation';
import { Menu, X, MapPin } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

const navLinks = [
  { name: 'Beranda', href: '/' },
  { name: 'Tentang Kami', href: '/about' },
  { name: 'Layanan', href: '/service' },
  { name: 'Produk', href: '/product' },
  { name: 'Kontak', href: '/contact' },
];

export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const pathname = usePathname();

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  if (pathname === '/login') {
    return null;
  }



  return (
    <nav
      className={`fixed w-full z-50 transition-all duration-300 bg-white shadow-sm py-4`}
    >
      <div className="container mx-auto px-6 flex justify-between items-center relative">
        <Link href="/" className="flex items-center space-x-2 group">
          <Image
            src="/images/logo.jpg"
            alt="SegarTani Logo"
            width={60}
            height={60}
            className="h-12 w-auto object-contain"
          />
          <span className={`text-2xl font-bold text-primary tracking-tight`}>
            Segar<span className="text-secondary">Tani</span>
          </span>
        </Link>

        {/* Desktop Menu Links (Centered) */}
        <div className="hidden md:flex absolute left-1/2 transform -translate-x-1/2 items-center space-x-8">
          {navLinks.map((link) => (
            <Link
              key={link.name}
              href={link.href}
              className={`text-sm font-medium transition-colors hover:text-primary ${pathname === link.href ? 'text-primary-dark border-b-2 border-primary-dark' : 'text-gray-700'
                }`}
            >
              {link.name}
            </Link>
          ))}
        </div>

        {/* Desktop Button and Mobile Hamburger */}
        <div className="flex items-center gap-4">
          <div className="hidden md:flex items-center gap-4">
            <Link
              href="/location"
              className="flex items-center gap-2 text-sm font-bold text-gray-700 hover:text-primary bg-gray-50 px-4 py-2 rounded-full transition-all"
            >
              <MapPin size={16} className="text-primary" />
              Cari Lokasi
            </Link>
            <Link
              href="/login"
              className="bg-primary text-white px-6 py-2 rounded-full text-sm font-semibold hover:bg-primary-dark transition-all transform hover:scale-105 inline-block"
            >
              Daftar
            </Link>
          </div>

          {/* Mobile Menu Button */}
          <div className="md:hidden">
            <button
              onClick={() => setIsOpen(!isOpen)}
              className="text-gray-700 hover:text-primary transition-colors focus:outline-none"
            >
              {isOpen ? <X size={28} /> : <Menu size={28} />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Menu Overlay */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            className="md:hidden bg-white border-t border-gray-100 overflow-hidden"
          >
            <div className="container mx-auto px-6 py-6 flex flex-col space-y-4">
              {navLinks.map((link) => (
                <Link
                  key={link.name}
                  href={link.href}
                  onClick={() => setIsOpen(false)}
                  className={`text-lg font-medium transition-colors ${pathname === link.href ? 'text-primary-dark' : 'text-gray-700'
                    }`}
                >
                  {link.name}
                </Link>
              ))}

              <Link
                href="/location"
                onClick={() => setIsOpen(false)}
                className="flex items-center gap-2 text-lg font-medium text-gray-700 hover:text-primary transition-colors border-t border-gray-50 pt-4"
              >
                <MapPin size={20} className="text-primary" />
                Cari Lokasi
              </Link>

              <Link
                href="/login"
                onClick={() => setIsOpen(false)}
                className="bg-primary text-white text-center px-6 py-3 rounded-xl font-semibold hover:bg-primary-dark transition-colors"
              >
                Daftar
              </Link>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </nav>
  );
}
