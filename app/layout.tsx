import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import { CartProvider } from "@/context/CartContext";
import { WishlistProvider } from "@/context/WishlistContext";
import CartDrawer from "@/components/CartDrawer";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "SegarTani - Sayur & Buah Organik Segar Berkualitas",
  description: "SegarTani menyediakan pilihan sayuran dan buah organik segar langsung dari petani lokal di Batu, Jawa Timur.",
  keywords: ["sayur organik", "buah segar", "agribisnis", "SegarTani", "makanan sehat"],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="id"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col font-sans">
        <CartProvider>
          <WishlistProvider>
            <Navbar />
            <main className="flex-grow pt-20">
              {children}
            </main>
            <Footer />
            <CartDrawer />
          </WishlistProvider>
        </CartProvider>
      </body>
    </html>
  );
}
